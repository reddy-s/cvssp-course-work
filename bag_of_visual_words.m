function bag_of_visual_words(dataDir, outputDir)

    if not(exist(outputDir,'dir'))
       mkdir(outputDir);
    end

    featuresDir = [outputDir, '/features'];
    if not(exist(featuresDir,'dir'))
       mkdir(featuresDir);
    end

    fpCollection = [];
    fd = [];
    allfiles=dir (fullfile([dataDir,'/Images/*.bmp']));
    for filenum=1:length(allfiles)
        tic;
        fname=allfiles(filenum).name;
        fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
        imgfname_full=([dataDir,'/Images/',fname]);
        img = imread(imgfname_full);
        finger_print=feature_descriptor(img);
        finger_print.fileLocation = imgfname_full;
        finger_print.fileName = fname;
        fpCollection = [fpCollection; finger_print];
        
        for i=1:size(finger_print.descriptor, 1)
            fd = [fd; finger_print.descriptor(i).descriptor];
        end

        fout=[featuresDir,'/',fname(1:end-4),'.mat'];
        save(fout,'finger_print');
        toc
    end
    sout = [featuresDir,'/summary.mat'];
    save(sout, 'fd');

    [idx, C] = kmeans(fd, 128);
    
    clear fd;
    clear finger_print;

    for i=1:size(fpCollection, 1)
        tic;
        bins = [];
        dst = [];
        fp = fpCollection(i);
        fprintf('Processing finger print for %d/%d - %s\n',i,size(fpCollection, 1),fp.fileName);
        for j=1:size(fp.descriptor, 1)
            for k=1:size(C, 1)
                distance = l2_norm(fp.descriptor(j).descriptor, C(k, :));
                dst = [dst; [distance k]];
            end
            dst = sortrows(dst, 1);
            bins = [bins, dst(1, 2)];
        end
        F = histcounts(bins, size(C, 1));
        F = F ./ sum(F);
        dout = [outputDir, '/', fp.fileName(1:end-4),'.mat'];
        save(dout, 'F');
        toc
    end
end

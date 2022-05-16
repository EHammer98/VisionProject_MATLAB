function img_create_batch(obj, img, batch_size, folder, batch_nr, category, name)

% This function creates a batch of randomised images from a given image

    for i = 1 : 1 : batch_size
    
        curr_img = img;
        curr_folder = folder;

        curr_img = obj.img_randomise(curr_img);
        curr_img = obj.img_crop_center(curr_img);

        curr_folder = append(curr_folder, '/0', string(batch_nr), '/0', string(category), '_', name);
        filename = append('0', string(batch_nr), '_', '0', string(category), '_', name, '_', string(i), '.png');
        path = fullfile(curr_folder, filename);
        imwrite(curr_img, path);
    
    end

    disp('Batch created in folder:');
    disp(folder);

end
%#ok<*SEPEX> 

function img_out = img_randomise(obj, img, allow_flip, amin, amax, edmin, edmax, trxmin, trxmax, trymin, trymax)

% This function takes an image (binary format) and randomises it slightly;
% Randomisations are rotation, erosion/dilation and translation (both X and Y axis)
% Each randomisation has a 33% chance to occur, but at least one randomisation has to occur.
% The randomisations are executed in a random order
%
% Arguments:
%  * obj: -
%  * img: image
%  * allow_flip: can the image be flipped horizontally?
%  * amin: minimum rotation angle
%  * amax: maximum rotation angle
%  * edmin: minimum erosion/dilation radius
%  * edmax: maximum erosion/dilation radius
%  * trxmin: minimum translation across X-axis
%  * trxmax: maximum translation across X-axis
%  * trymin: minimum translation across Y-axis
%  * trymax: maximum translation across Y-axis

% Change randomiser seed
rng shuffle;

% Assign default values if necessary
if (nargin < 11) trymax = obj.rand_trymax; end
if (nargin < 10) trymin = obj.rand_trymin; end
if (nargin < 9) trxmax = obj.rand_trxmax; end    
if (nargin < 8) trxmin = obj.rand_trxmin; end
if (nargin < 7) edmax = obj.rand_edmax; end
if (nargin < 6) edmin = obj.rand_edmin; end
if (nargin < 5) amax = obj.rand_amax; end
if (nargin < 4) amin = obj.rand_amin; end
if (nargin < 3) allow_flip = 1; end

% Randomise parameters
imflip = allow_flip;
ang = round(amin + (amax - amin) * rand());
ed = round(rand());
edr = round(edmin + (edmax - edmin) * rand());
tr_x = round(trxmin + (trxmax - trxmin) * rand());
tr_y = round(trymin + (trymax - trymin) * rand());
tr_x_dir = round(rand());
tr_y_dir = round(rand());

if (tr_x_dir == 0) tr_x_dir = -1; end
if (tr_y_dir == 0) tr_y_dir = -1; end

if (imflip == 1) 
    img = flip(img, 2); 
end

SE = strel('disk', edr);

% Determine order of operations
actions = [0, 0, 0];
actions_order = randperm(3, 3);

% Ensure at least one randomisation occurs
while (actions == 0)
    actions = round( [rand(), rand(), rand()] );
end

% Loop over operations (required to change order of operations)
for i = 1:1:3
    if (actions(1) == 1 && actions_order(1) == i)
        img = imrotate(img, ang);
        img = obj.img_grow(img, 25);
    end

    if (actions(2) == 1 && actions_order(2) == i)
        if (ed == 0)
            img = obj.img_shrink(img, edr);
        else
            img = obj.img_grow(img, edr);
        end
    end

    if (actions(3) == 1 && actions_order(2) == i)
        img = imtranslate(img, [tr_x * tr_x_dir, tr_y * tr_y_dir], 'FillValues', 0);
    end
end

img_out = img;

end
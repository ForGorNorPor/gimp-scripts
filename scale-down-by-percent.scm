(define (batch-scale-by-percentage sourceDirectory pattern percentage)
	(let* 
		(
			(patt (string-append sourceDirectory "\\" pattern))
			(filelist (cadr (file-glob patt 1)))
		)
		(while (not (null? filelist))
			(let* 
				(
					(filename (car filelist))
					(image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
					(drawable (car (gimp-image-get-active-layer image)))
				)
				(let* 
					(
						(width (car (gimp-drawable-width drawable)))
						(height (car (gimp-drawable-height drawable)))
					)
					(gimp-image-scale image 
						(/ (* width percentage) 100)
						(/ (* height percentage) 100))
					)
				(gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
				(gimp-image-delete image)
			)
			(set! filelist (cdr filelist))
		)
	)
)

(script-fu-register "batch-scale-by-percentage"
			_"<Toolbox>/Xtns/Batch Tools/Batch scale by percentage..."
			"Scales all images in the target folder by given percentage"
			"Mr Public Domain"
			"Mr Public Domain"
			"April 2019"
			""
			SF-DIRNAME "Image directory" ""
			SF-STRING "Pattern" "*.jpg"
			SF-VALUE "Percent" "20")
;; My Config                                                                                                        

;; Line Numbers
(global-linum-mode)                                                                                                 
                                                                                  
;; Save edited tmp files
(setq backup-directory-alist `(("." . "~/.saves")))

;; Personal View Preference
(setq linum-format "%4d \u2502 ")
(global-hl-line-mode)                                                                                               
(package-initialize)                                                                                                
(unless (display-graphic-p)                                                                                         
  (menu-bar-mode -1))
(display-time-mode 1)

;; Tab == 4 spaces 
(setq-default indent-tabs-mode t)                                                                                   
(setq-default tab-width 4)                                                                                          
(defvaralias 'c-basic-offset 'tab-width)                                                                                                                    

;; My Themes                                                                                                        
(setq c-default-style "linux")                                                                                      
(setq c-basic-offset 4)                                                                                             
(c-set-offset 'comment-intro 0)                                                                                     

;; Theme Path
(add-to-list 'custom-theme-load-path "~/.emacs.d/theme/atom-one-dark-theme")                                        
(load-theme 'atom-one-dark t)                                                                                       
(custom-set-variables                                                                                               
 ;; custom-set-variables was added by Custom.                                                                       
 ;; If you edit it by hand, you could mess it up, so be careful.                                                    
 ;; Your init file should contain only one such instance.                                                           
 ;; If there is more than one, they won't work right.                                                               
 '(ansi-color-faces-vector                                                                                          
   [default default default italic underline success warning error])                                                
 '(ansi-color-names-vector                                                                                          
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])                               
 '(custom-enabled-themes '(atom-one-dark))                                                                          
 '(custom-safe-themes                                                                                               
   '("0c860c4fe9df8cff6484c54d2ae263f19d935e4ff57019999edbda9c7eda50b8" default))                                   
 '(fci-rule-color "#3E4451")                                                                    
 '(tetris-x-colors                                                                                                  
   [[229 192 123]                                                                                                   
    [97 175 239]                                                                                                    
    [209 154 102]                                                                                                   
    [224 108 117]                                                                                                   
    [152 195 121]                                                                                                   
    [198 120 221]                                                                                                   
    [86 182 194]]))                                                                                                 
(custom-set-faces                                                                                                   
 ;; custom-set-faces was added by Custom.                                                                           
 ;; If you edit it by hand, you could mess it up, so be careful.                                                    
 ;; Your init file should contain only one such instance.                                                           
 ;; If there is more than one, they won't work right.                                                               
 )

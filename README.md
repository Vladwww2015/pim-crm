#  CRM(Espo) and PIM(Atro) Projects
- https://github.com/atrocore/atropim
- https://docs.espocrm.com/

## Requirements
1) Ubuntu terminal(MacOs)
2) Installed Docker-Desktop

## Install CRM(ESPO) project
https://docs.espocrm.com/administration/installation-by-script/
### Ubuntu terminal:
#### Go to project folder
1) Run command `` make crm ``
2) Follow the terminal instructions
3) Access to the admin panel will be generated and displayed in the terminal. Save it

## PIM(Atro) Installation guide
### Ubuntu terminal:
#### Go to project folder 
1) ``` cd /to/project/folder ```
2) ``` make pim ```
3) After installation in the terminal, go to browser and open 
``` http://localhost:8095/ ```
4) Use Database credentials for install project:
- Host: `` atropim_mysql ``
- Database Name, User Name And Password eq: `` atropim ``
- The Port field must be empty.


## DAM(Atro) Installation guide
### Ubuntu terminal:
#### Go to project folder 
1) ``` cd /to/project/folder ```
2) ``` make dam ```
3) After installation in the terminal, go to browser and open 
``` http://localhost:8096/ ```
4) Use Database credentials for install project:
- Host: `` atrodam_mysql ``
- Database Name, User Name And Password eq: `` atrodam ``
- The Port field must be empty.



# France
F_LAT_LT=51.64487373571973 # France Latitude Left Top Corner
F_LON_LT=-8.368597820416705 # France Longitude Left Top Corner
F_LAT_RB=39.57130037985029 # France Latitude Left Right Bottom
F_LON_RB=13.648001165160654 # France Longitude Left Right Bottom

# French Guyana
G_LAT_LT=7.414096301143184
G_LON_LT=-56.200797217372816
G_LAT_RB=0.952896781628659
G_LON_RB=-48.92784884988169

# Saint-Pierre-et-Miquelon
S_LAT_LT=47.44548997504316
S_LON_LT=-57.0692140541847
S_LAT_RB=46.538776133793036
S_LON_RB=-55.54211462354836

# Antillas
A_LAT_LT=28.688585531099605
A_LON_LT=-88.95368047705902
A_LAT_RB=10.09642350556106
A_LON_RB=-57.664621330658946

# Indian Ocean
O_LAT_LT=12.245886385926374
O_LON_LT=30.914494141083015
O_LAT_RB=-54.957228044993705
O_LON_RB=113.26800598042425

# Antartic
Q_LAT_LT=-61.155580835508296
Q_LON_LT=-180
Q_LAT_RB=-90
Q_LON_RB=180

# Names of all options
OPTIONS=":f:d:t:p:whmFGSAOQ-:"

# Store option arguments
OPTION_f=""
OPTION_t=""
OPTION_p=""
OPTION_d=()

# Option usage counters
OPTION_f_ARG_COUNT=0
OPTION_d_ARG_COUNT=0

# Options flags
f_FLAG=false
d_FLAG=false
t_FLAG=false
t1_FLAG=false
t2_FLAG=false
t3_FLAG=false
t4_FLAG=false
p_FLAG=false
p1_FLAG=false
p2_FLAG=false
p3_FLAG=false
p4_FLAG=false
w_FLAG=false
h_FLAG=false
m_FLAG=false
data_type_FLAG=false

location_FLAG=0
sort_FLAG=0

locations=("all areas" "metropolitan France" Guyana "Saint-Pierre and Miquelon" "French Antilles" "Indian Ocean" "Antartic")

COLOR_NC='\e[0m'
COLOR_GRAY='\e[1;30m'
COLOR_PURPLE='\e[1;35m'
From: Ralph Crongeyer <rcrongeyer@rpicc.com>
Subject: Static with Intel 82801CA-ICH3 Driver in ALSA 0.9.6
Date: Tue, 23 Sep 2003 10:40:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309231040.57534.rcrongeyer@rpicc.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm having trouble with the Intel 82801CA-ICH3 Driver in ALSA 0.9.6. All I 
here is static. I have removed the config files after uninstalling 0.9.4 and 
then installing alsa-drivres, alsa-utils, and alsa-lib (0.9.6 version). And 
all I get is noise? 
This is hapining on a Toshiba Satellite 5105-S501 laptop using the Lunar-Linux 
distro with the 2.4.20 Kernel and compiled with gcc 3.2.3.

It's definitely not mixer settings, I can reset them all and turn them up to 
20% and it still comes and goes. It's white noise, not like the channel is 
overdriven.

Is any one else experiencing this?

Ralph



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: USB recording - repetitive peaks
Date: Tue, 02 Jul 2002 23:28:08 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D21B878.8090902@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de> <s5hhejibem0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Thanks to your patch Takashi we have two people who have been able to 
record through the quattro.

We have both found that there is a constant repetitive peak in the 
signal which reminds me of the problems I had with the cmipci for a 
brief period.

Thorsten Hass has recorded a perfect example for you which he did using 
aplay and arecord. It is a sine wave so is easy on the ears.

http://www.thorstenhaas.de/alsa/audio.file

He has also generated a jpeg plotted by an oscilloscope while recording 
which I can send you if it will help.

He has also asked if there is any chance you will have time to look at 
this in the two weeks. I believe he has to do some work with his device 
so needs to make a decision about which OS to use for the job.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

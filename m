From: Z_God <z_god@wanadoo.nl>
Subject: Samplerate convertor changes
Date: Fri, 16 May 2003 14:44:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305161444.46432.z_god@wanadoo.nl>
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

Hi,
My onboard sound is a lockedrate Via686a. After I upgraded from SuSE 8.1 to 
SuSE 8.2, you could suddenly hear small cracks through the sound. I then 
updated the version of ALSA that came with SuSE 8.2 to 0.9.3a, because I 
hoped that would fix the problem. That didn't help though.
I found that when I play sound through aRts, using aRts to convert the 
samplerate to 48kHz, the sound didn't have any cracks. What should I do? Has 
something been changed from the samplerate converter that comes with ALSA?  
Could this be a bug in newer versions of ALSA? Older versions used to work 
perfectly out of the box. Thanks in advance,
Z


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

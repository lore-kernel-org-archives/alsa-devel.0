From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: CMIPCI driver. Q about snd_stru_cmipci struct fields
Date: Sun, 15 Oct 2006 14:56:01 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E4E66A@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Rita Shtern <rita@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi,
Where can I find a detailed description of the snd_stru_cmipci structure
(file cmipci.c). I'm especially interested in the below fields:
	unsigned int can_ac3_sw: 1;
	unsigned int can_ac3_hw: 1;
	unsigned int can_multi_ch: 1;
	unsigned int do_soft_ac3: 1;
	unsigned int dig_status;
	unsigned int dig_pcm_status;
Thanks.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

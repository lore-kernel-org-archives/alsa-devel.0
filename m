From: Barry Scott <barry.scott@onelan.co.uk>
Subject: Alsa v1.0.12rc1 Realtek ALC260 PCM missing at boot
Date: Tue, 27 Jun 2006 12:54:05 +0100
Message-ID: <44A11C5D.7010606@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

I'm using 21.6.17.1 with v1.0.12rc1 drivers, libs and utils on FC4.
alsamixer reports that the Chip is Realtek ALC260.

Both amixer and alsamixer show that the PCM control is missing after 
booting.
After playing a wav file with aplay the PCM control shows up in both
amixer and alsamixer.

Is there something I need to configure or is this a bug in1.0.12rc1?

Barry


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

From: "Vishwas P S" <vishwas.ps@gmail.com>
Subject: Alsamixer capture controls
Date: Tue, 6 Feb 2007 14:41:01 +0530
Message-ID: <64cf23610702060111s28f9c232t304af4b3393b53ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

I need to control the capture devices(Mics)on my system. If I name the
corresponding kcontrol component as "Master Capture Route", alsamixer
does not recognise that but If I name it as "Master Input capture
Volume" (I named it this way just to get it recognised, no sp rerason
whatsoever), it gets recognised.

Master Capture Route seems to be a valid name and the latter does not
but the behaviour is just the opposite.
Pl help me out.

Thanks in advance
- Vishwas

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

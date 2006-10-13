From: Tom Horsley <tomhorsley@adelphia.net>
Subject: global normalization of sound level?
Date: Fri, 13 Oct 2006 10:03:05 -0400
Message-ID: <30532188.1160748185528.JavaMail.root@web35>
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

After being blasted out of my chair for about the umpteenth
time when an app with really loud sound started after I was
using an app with really soft sound, I went looking for some
global sound setting that could solve my problem.

I didn't find anything (other than a few individual apps with
a normalization mode, but that doesn't help when sound is
coming from lots of different sources). I did find this bug
report from someone else with the same desire:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1871

If I get blasted out of my chair a few more times, I may
actually develop enough energy to want to work on a fix

Can anyone say if this would even be possible to do within the
architecture of alsa? Where would I start to learn enough to
figure out how to do it? Where within the alsa architecture
could such a control best be wedged in? Is such a control
already under development by someone else?

Thanks for any pointers you can provide.

P.S. I know this will ruin the artistic purity of music with a
large dynamic range - when I'm feeling artistic, I'll disable
the control, but for normal day to day usage I'd really like
it enabled :-).


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

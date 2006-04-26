From: Brad Midgley <bmidgley@xmission.com>
Subject: bluetooth plugin "jittery" and "sticky"
Date: Wed, 26 Apr 2006 03:09:15 -0600
Message-ID: <444F38BB.4020702@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

We finally got around to working on the stereo (a2dp) bluetooth alsa
plugin. It's mostly working in the cvs version of the project "btsco" at
http://bluetooth-alsa.sf.net.

One thing that isn't quite right is the readout in xmms jitters back and
forth and xmms often gets stuck and crashes with "Message: alsa mixer
timed out" at the end of the song. Is there something we should be
looking at or are there common gotchas we should know about in writing
plugins?

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

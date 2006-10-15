From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Sample code for simple ALSA API usage
Date: Sun, 15 Oct 2006 11:47:39 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E4E5CF@msilexch01.marvell.com>
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
I'm new to ALSA and I would be happy to see a simple code that
demonstrates the usage of the following API:
to perform playback:
snd_pcm_write,
snd_pcm_writev,
snd_pcm_open,
snd_pcm_release,
snd_pcm_playback_poll,
snd_pcm_playback_ioctl,
snd_pcm_ioctl_compat,
snd_pcm_mmap,
snd_pcm_fasync,


To perform capture:
snd_pcm_read,
snd_pcm_readv,
snd_pcm_open,
snd_pcm_release,
snd_pcm_capture_poll,
snd_pcm_capture_ioctl,
snd_pcm_ioctl_compat,
snd_pcm_mmap,
snd_pcm_fasync,

Thanks in advance.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

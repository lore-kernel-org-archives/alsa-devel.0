From: Wiebe Cazemier <halfgaar@gmx.net>
Subject: Re: Inverted front speakers on sb live
Date: Tue, 11 Jul 2006 12:49:27 +0200
Message-ID: <e8vvnn$5qv$1@sea.gmane.org>
References: <e8ihr6$jq$1@sea.gmane.org> <s5hodvwxw2o.wl%tiwai@suse.de>
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

On Tuesday 11 July 2006 12:41, Takashi Iwai wrote:

> There are some tools in alsa-tools package, as10k1 (ALSA version) and
> ld10k1.  Try it out.

I don't have ld10k1.

These are all the files in /usr/bin that alsa-tools provide:

/usr/bin/ac3dec
/usr/bin/as10k1
/usr/bin/cspctl
/usr/bin/echomixer
/usr/bin/envy24control
/usr/bin/extract_ac3
/usr/bin/hdsploader
/usr/bin/mixartloader
/usr/bin/rmedigicontrol
/usr/bin/sbiload
/usr/bin/sscape_ctl
/usr/bin/us428control
/usr/bin/usx2yloader
/usr/bin/vxloader

Hmm, this is strange. Alsa-tools 1.0.11 I installed in Gentoo doesn't have
ld10k1, but the tar file of 1.0.10 does have it. I wonder why it's not
installed in Gentoo. At least I have something to go on now. Thanks.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

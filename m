From: Christoph Lameter <christoph@lameter.com>
Subject: Re: P4M800PRO Mobo with VIA8237 (ALC655) no sound
Date: Mon, 7 Aug 2006 12:11:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608071210280.6493@graphe.net>
References: <Pine.LNX.4.64.0608041624260.9917@graphe.net>
	<s5hwt9kralg.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608070930080.3308@graphe.net>
	<s5hfyg8s9j7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyg8s9j7.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Aug 2006, Takashi Iwai wrote:

> Your box is cursed ;-)

Gosh. I need an an exorcist?

> > > Otherwise, it's a problem of ac97 mixer setting for ALC655.
> > > Please attach the generated file by "alsactl -f somefile store", and 
> > > the contents of /proc/asound/card0/codec97#0/* files for further
> > > checking.
> 
> The mixer looks really OK.
> Any influence by turning on "External Amplifier" mixer swith?

None. Just tried it again. I have toyed with these options for a long 
time.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

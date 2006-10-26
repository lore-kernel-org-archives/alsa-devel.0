From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [PATCH] hda: add sigmatel dig mic support
	and	refactor 9227
Date: Thu, 26 Oct 2006 07:54:30 -0700
Message-ID: <1161874470.18211.90.camel@razman>
References: <20061025202110.GA351@matthew-porters-computer.local>
	<1161809636.18211.65.camel@razman>
	<20061026133820.GA1507@matthew-porters-computer.local>
	<s5hejsvdwkf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 875BA224
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Oct 2006 16:54:33 +0200 (MEST)
In-Reply-To: <s5hejsvdwkf.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Matt Porter <mporter@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Ok, I figured out what I did wrong.  I should have saved the original
email, trimmed the email header out, then apply the patch as opposed to
highlighting it and copy/paste into gvim.

That's what I get for coding before caffeine.

Tobin
On Thu, 2006-10-26 at 15:40 +0200, Takashi Iwai wrote:
> At Thu, 26 Oct 2006 09:38:20 -0400,
> Matt Porter wrote:
> > 
> > On Wed, Oct 25, 2006 at 01:53:56PM -0700, Tobin Davis wrote:
> > > Couple of things, which version is this against?  I tried patching
> > > against the tip and all areas were rejected.
> > 
> > Update your hg tree, I checked against a fresh tree and it applies
> > cleanly.
> 
> Yes, I could apply it without hitch, too.
> 
> 
> Takashi
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

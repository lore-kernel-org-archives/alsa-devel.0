From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: rfc: rewrite commit subject line for subsystem
 maintainer preference tool
Date: Tue, 16 Nov 2010 16:55:56 -0800
Message-ID: <20101116165556.3ee8e236.rdunlap@xenotime.net>
References: <1289850773.16461.166.camel@Joe-Laptop>
	<20101116104921.GL12986@rakim.wolfsonmicro.main>
	<1289919077.28741.50.camel@Joe-Laptop>
	<20101116183707.179964dd@schatten.dmk.lab>
	<20101116181226.GB26239@rakim.wolfsonmicro.main>
	<20101116203522.65240b18@schatten.dmk.lab>
	<20101116195530.GA7523@rakim.wolfsonmicro.main>
	<20101116122102.86e7e0b9.rdunlap@xenotime.net>
	<1289940156.28741.207.camel@Joe-Laptop>
	<20101116124609.382e42fb.rdunlap@xenotime.net>
	<20101116232258.GC24623@opensource.wolfsonmicro.com>
	<20101116152835.b0ab571c.rdunlap@xenotime.net>
	<1289951875.28741.261.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xenotime.net (xenotime.net [72.52.115.56])
	by alsa0.perex.cz (Postfix) with SMTP id 043F124436
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 01:56:06 +0100 (CET)
Received: from chimera.site ([173.50.240.230]) by xenotime.net for
	<alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 16:55:57 -0800
In-Reply-To: <1289951875.28741.261.camel@Joe-Laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Jiri Kosina <trivial@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Nov 2010 15:57:55 -0800 Joe Perches wrote:

> On Tue, 2010-11-16 at 15:28 -0800, Randy Dunlap wrote:
> > On Tue, 16 Nov 2010 23:22:58 +0000 Mark Brown wrote:
> > > On Tue, Nov 16, 2010 at 12:46:09PM -0800, Randy Dunlap wrote:
> > > > On Tue, 16 Nov 2010 12:42:36 -0800 Joe Perches wrote:
> > > > > Some subsystem maintainers like upper case, some mixed, some lower.
> > > > > Some aren't consistent.  (Staging/staging)
> > > > Case usually doesn't matter to most of us.
> > > Given that we're working in case sensitive languages here it's probably
> > > safe to assume that a reasonable proportion of people will care; being
> > > reasonably consistent with existing practice for the subsystem seems
> > > sensible.
> > Greg takes patches that say STAGING or Staging or staging.
> 
> Greg seems to rewrite patch subjects and is inconsistent
> about case, so he might be doing that by hand.
> 
> > DaveM takes patches that say net: or netdev: or network: or NET:
> 
> DaveM doesn't appear to be choosy about patch subject lines.
> He seems to take any sensible patch and as far as I know he
> doesn't edit the subject lines.  He does reject inferior
> patches outright.
> 
> > The sound maintainers take patches that say sound: or alsa: or ALSA:
> 
> The sound maintainers seem to rewrite patch subjects on an
> ad-hoc basis.

OK, I can accept your summary.
However, I can't tell that we are making any progress.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

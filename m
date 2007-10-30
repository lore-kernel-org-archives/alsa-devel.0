From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Testers Wanted: OPL3 hwdep loader interface
Date: Tue, 30 Oct 2007 09:24:42 +0100
Message-ID: <1193732682.30948.1218541281@webmail.messagingengine.com>
References: <s5hfxzyoxvf.wl%tiwai@suse.de> <47223817.7060508@keyaccess.nl>
	<472273AC.9020702@keyaccess.nl>
	<1193643700.13559.1218328069@webmail.messagingengine.com>
	<s5hir4qnvcr.wl%tiwai@suse.de> <47260F8B.5010406@keyaccess.nl>
	<s5hd4uylzt3.wl%tiwai@suse.de> <472626A9.4050509@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4CBC8246BF
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 09:24:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <472626A9.4050509@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 10/29/2007 04:12 PM, Takashi Iwai wrote:
> >> Yes, I believe my OPL3 is back to its good ol' horrible self again with that
> >> version.

Here too.

> >> Do you by the way know of other, nicer and/or better patches than the 
> >> supplied std and drums? Couldn't find any, at least not in the correct 
> >> format it seems.

I think I could poke around in some old Yamaha driver ...

> > Hm, I don't know of others.  It'd be fun to play with OPL3 parameter
> > adjustment, though ;)
> 
> I was thinking of whether or not the standard patches shouldn't simple be 
> builtin but anyone playing with an OPL3 these days is sort of by definition 
> going for the geekness factor I guess. From that viewpoint, external patches 
> do sound better...

Trying to get General MIDI out of this chip doesn't do it justice.

Maybe I should put opledit into alsa-tools ...


Regards,
Clemens

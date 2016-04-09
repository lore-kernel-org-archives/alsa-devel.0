From: Gordon Scott <gordon@gscott.co.uk>
Subject: Re: [FFADO-devel] [PATCH 4/4] ALSA: dice: force to add
 two pcm devices for listed models
Date: Sat, 09 Apr 2016 17:45:41 +0100
Message-ID: <1460220341.3402.3.camel@gordon-coolled.gscott.co.uk>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-5-git-send-email-o-takashi@sakamocchi.jp>
 <20160305160733.6306be3f@kant> <56DC2514.2010101@sakamocchi.jp>
 <20160306235521.7aabff60@kant> <20160307012442.6935bc04@kant>
 <56DCEF78.2080107@sakamocchi.jp> <20160307144306.39f60537@kant>
 <56DD8D1B.5040903@sakamocchi.jp> <20160409183427.00a59f1b@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dmz.gscott.co.uk (87-127-155-63.static.enta.net [87.127.155.63])
 by alsa0.perex.cz (Postfix) with ESMTP id 2534E261685
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2016 18:45:43 +0200 (CEST)
In-Reply-To: <20160409183427.00a59f1b@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org


Just a reminder in case it gets overlooked.

The new Focusrite Saffire Pro 40, as of a few months ago, is now a Dice
III.

Focusrite were going to contact me again about that "after Christmas",
but despite a couple of reminders, I've heard nothing more.

Gordon.

On Sat, 2016-04-09 at 18:34 +0200, Stefan Richter wrote:
> On Mar 07 Takashi Sakamoto wrote:
> > On Mar 7 2016 22:43, Stefan Richter wrote:
> > > On Mar 07 Takashi Sakamoto wrote:
> > >>   * Dice II units
> > >>    * TC Electronic ImpactTwin
> > >>    * TC Electronic Konnekt24D
> > >>    * TC Electronic Konnekt8
> > >> * Dice Jr. units
> > >>    * TC Electronic DesktopKonnect6
> > >> * Dice Mini units
> > >>    * Focusrite Saffire Pro 26  
> > > 
> > > FWIW, Saffire PRO 24 and 40 are based on Dice Junior according to FFADO's
> > > device database.  If desired I could open up my 24 and 40 to check.  
> > 
> > If you don't mind it, please.
> > (Because once opening your unit, usually, you cannot get repair service
> > from sellers.)
> > 
> > And I wrote wrong for Dice Jr./Mini units. Correctly:
> >  * Dice Jr. units
> >   * TC Electronic DesktopKonnect6
> >   * Focusrite Saffire Pro 26
> >  * I have no units with Dice Mini (Oh...).
> > 
> > Anyway, all of my units with Dice Jr. works fine. So we can judge that
> > Pro 40 has its own quirk which we don't know.
> 
> Written on the Dice chip in my Saffire PRO 24, purchased in 2010:
> 
> 	TCD2210
> 	K34FAAB
> 	C0906
> 
> So that's a DICE Mini.
> 
> And the Saffire PRO 40, purchased in early 2015:
> 
> 	TCD2220
> 	K8GVUF
> 	A1246
> 
> i.e. DICE JR.

-- 
Gordon Scott.	Electronics and software engineering.
		Basingstoke UK
		+44-1256-476547

But for the sake of some little mouthful of flesh 
we deprive a soul of the sun and light, 
and of that proportion of life and time 
it had been born into the world to enjoy. 
=== Plutarch AD44-120

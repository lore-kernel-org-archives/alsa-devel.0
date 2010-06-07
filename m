From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCH v3 0/3] ep93xx i2s audio
Date: Tue, 08 Jun 2010 08:35:42 +1200
Message-ID: <4C0D581E.3010802@bluewatersys.com>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<20100607132634.GE5993@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 0351810380B
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 22:35:55 +0200 (CEST)
In-Reply-To: <20100607132634.GE5993@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: john.cooper@third-harmonic.com, alsa-devel@alsa-project.org, chasedouglas@gmail.com, buytenh@wantstofly.org, r&d4@dave-tech.it, hartleys@visionengravers.com, dhuggins@cs.cmu.edu, marshall@coolbananas.co.nz, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Jun 04, 2010 at 05:11:22PM +1200, Ryan Mallon wrote:
>> The following patch series adds support for i2s audio on the ep93xx,
>> with the Snapper CL15 used as an example implementation.
> 
> Please do remember to CC maintainers on patches.  I've had to remind you
> about this before, it's really not helpful to drop the people you're
> expecting to review the patches - it'll tend to delay things or lead to
> the patches getting missed.  From a code point of view this looks fine
> but we'll need an arch maintainer to sign off on that bit of the code.
> I've applied 2/3 since that has no arch/arm elements.

Sorry, again. I copied the CC list from the last series I sent. I must
have missed you accidentally.

Thanks for picking this up.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934

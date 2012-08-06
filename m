From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Plumbers: Please split audio topics into separate
	sessions
Date: Mon, 6 Aug 2012 22:45:31 +0100
Message-ID: <20120806214530.GB26698@opensource.wolfsonmicro.com>
References: <50201664.7000804@canonical.com>
 <20120806193858.GB16199@opensource.wolfsonmicro.com>
 <502025C0.2050508@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10D53265E07
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 23:15:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <502025C0.2050508@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 10:14:56PM +0200, David Henningsson wrote:
> On 08/06/2012 09:38 PM, Mark Brown wrote:

>> The two ASoC topics certainly don't need to be split, they're roughly
>> the same area.  I'd be really surprised if the last two were terribly
>> time consuming individually.

> What other topic than "DSPs on ASoC" are you referring to? I thought  
> "Expose routing" was not ASoC specific. At least it does not look that  
> way from the presentation text.

Those two - the routing is mostly an ASoC thing, HDA could use it but
none of the desktop guys ever seemed really interested and it's more
likely that any active work on that is going to come from people with
DSPs.  I guess ASoC isn't the right term, though.

From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v6 0/5] ASoC: core: Add support for DAI
	multicodec
Date: Mon, 28 Jul 2014 14:40:47 +0200
Message-ID: <53D644CF.4030500@baylibre.com>
References: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
 <53C659B9.70904@baylibre.com> <53C65D6D.6060400@metafoo.de>
 <20140716221904.GL17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 8319B261740
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 14:40:53 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id q58so7190104wes.7
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 05:40:51 -0700 (PDT)
In-Reply-To: <20140716221904.GL17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: misael.lopez@ti.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark and Lars,

On 17/07/2014 00:19, Mark Brown wrote:
> On Wed, Jul 16, 2014 at 01:09:33PM +0200, Lars-Peter Clausen wrote:
>> On 07/16/2014 12:53 PM, Benoit Cousson wrote:
>
>>> Any comment on that version?
>
>> No comments is probably a good sign in this case. There is just a lot of
>> activity on the ALSA mailinglist and lots of patches to review and this =
is a
>> quite invasive patchset so it requires a bit more thorough review. Give =
it
>> maybe two or three weeks. I'm quite confident that this version has a go=
od
>> chance of being merged.
>
> Right, if you make multi-hundred line changes to most of the core files
> it shouldn't be that surprising if it gets some careful review!

Sorry, I perfectly understand and did not mean to push you.
Since the series was quite intrusive, I was just expecting some more =

feedbacks from hackers complaining about regression on their audio =

system. So I was just surprised to not get any of that :-)

> Anyway,
> that should be everything merged now - thanks for stepping up and doing
> this, it's something people have been looking for for years.

You're welcome. And thanks a lot to Lars who was really helpful to help =

me getting the series ready for upstream.

I owe him a couple of beers if I can meet him at ELC-E / LPC :-)


Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com

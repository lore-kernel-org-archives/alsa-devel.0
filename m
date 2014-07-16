From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6 0/5] ASoC: core: Add support for DAI
	multicodec
Date: Wed, 16 Jul 2014 13:09:33 +0200
Message-ID: <53C65D6D.6060400@metafoo.de>
References: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
 <53C659B9.70904@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-124.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id AFB7B2651A5
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 13:09:30 +0200 (CEST)
In-Reply-To: <53C659B9.70904@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/16/2014 12:53 PM, Benoit Cousson wrote:
> Hi all,
>
> On 08/07/2014 23:19, Benoit Cousson wrote:
>> Hi Lars, Mark and Liam,
>>
>> Here is the sixth, and hopefully the last, version of the multicodec series.
>>
>> I've just removed the broken test I forgot to remove last time.
>>
>> The series is based on asoc/for-next (v3.16-rc3).
>>
>> Test and comments are welcome.
>
> Any comment on that version?

No comments is probably a good sign in this case. There is just a lot of 
activity on the ALSA mailinglist and lots of patches to review and this is a 
quite invasive patchset so it requires a bit more thorough review. Give it 
maybe two or three weeks. I'm quite confident that this version has a good 
chance of being merged.

- Lars

From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 18:49:16 +0200
Message-ID: <53D67F0C.3010207@metafoo.de>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>	<53D5ECA7.5090106@metafoo.de>	<20140728112055.GM17528@sirena.org.uk>	<CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>	<CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>	<20140728162715.GZ17528@sirena.org.uk>	<CAKON4OzrDeEbjzAgpB7f3NYcXGegUnF2+Hb1QZeZYKwztctkvg@mail.gmail.com>	<20140728163645.GA17528@sirena.org.uk>
 <CAKON4Ow6AfdunEq54f7U7YLrAhmiYeuAfHaAWq+ktoE1bYYGDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-003.synserver.de (smtp-out-003.synserver.de
 [212.40.185.3]) by alsa0.perex.cz (Postfix) with ESMTP id C8E35265125
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:49:19 +0200 (CEST)
In-Reply-To: <CAKON4Ow6AfdunEq54f7U7YLrAhmiYeuAfHaAWq+ktoE1bYYGDQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/28/2014 06:47 PM, jonsmirl@gmail.com wrote:
> On Mon, Jul 28, 2014 at 12:36 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Jul 28, 2014 at 12:33:57PM -0400, jonsmirl@gmail.com wrote:
>>
>>> So what do you want the device tree to look like?
>>> Example with no external amp.
>>> Example with external amp.
>>
>> To repeat what I said in a previous mail:
>
> I see the aux binding in soc-core.c
> Where is an example of how to use it in a device tree?

https://lkml.org/lkml/2014/4/28/318

Does pretty much them same though to what you proposed.

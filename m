From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Conversion to int16_t and resolution loss with
 rate converter plugins
Date: Mon, 9 Apr 2018 17:20:50 +0900
Message-ID: <916284a8-26cf-9ab9-b6f7-06a734b2fdc1@sakamocchi.jp>
References: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <b435dc74-b2fb-7e29-6bb5-778b262fb5c8@sakamocchi.jp>
 <MWHPR21MB0478AF6C62CC2AEABFF15533D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <1656f543-b23a-ca14-47f8-38e4ea559395@sakamocchi.jp>
 <84d7e31f-63f4-9021-2190-52a99ff314bb@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4A06F266C1C
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 10:20:53 +0200 (CEST)
In-Reply-To: <84d7e31f-63f4-9021-2190-52a99ff314bb@ivitera.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>, Flavio Protasio Ribeiro <flaviopr@microsoft.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 9 2018 16:38, Pavel Hofman wrote:
> Dne 9.4.2018 v 09:32 Takashi Sakamoto napsal(a):
>> Hi,
>> =A0> =

>> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/0667=
64.html =

>>
>>
>> I get 404 from these links. Could I request more detail about a
>> requirement of modification for libsoxr?
>>
> Hi Takashi,
> =

> =

> The links work fine for me, but here are alternatives:
> =

> http://alsa-devel.alsa-project.narkive.com/u9WYIjpV/pcm-rate-api-question
> =

> https://www.google.com/search?q=3DThere%27s+an+ongoing+attempt+to+see+if+=
libsoxr-lsr+can+be+used+as+a+plug-in+replacement+for+libsamplerate+in+pulse=
audio+and+in+alsa+%28libsoxr-lsr+is+designed+with+this+usage+in+mind%29. =


Ah... sorry but I mean that two links in the above pages. In short,
below URLs:
  - =

http://blog.ivitera.com/pavel/linux-audio/pulseaudio-with-ld_preloading-lib=
soxr-lsr
  - =

http://blog.ivitera.com/pavel/linux-audio/simple-use-of-libsoxr-lsr-in-alsa=
-using-ld_preload


Thanks

Takashi Sakamoto

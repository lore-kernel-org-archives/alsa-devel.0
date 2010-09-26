From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] ASoC: Add Jassi Brar as Samsung maintainer
Date: Sun, 26 Sep 2010 19:38:05 +0900
Message-ID: <AANLkTi=xEwPGsf756EG3c4sC5F4mDevoXwcMtSYnrXt_@mail.gmail.com>
References: <1285402601-10131-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTik5q1B9B5V0rUHVfAXPHe7vWbxJm3dK_A6QfTJ=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D9E101037F2
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Sep 2010 12:38:06 +0200 (CEST)
Received: by wya21 with SMTP id 21so1091106wya.38
	for <alsa-devel@alsa-project.org>; Sun, 26 Sep 2010 03:38:06 -0700 (PDT)
In-Reply-To: <AANLkTik5q1B9B5V0rUHVfAXPHe7vWbxJm3dK_A6QfTJ=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Good news,

At the first work, can you proceed the directory name change from
s3c24xx to samsung?

it's really misleading and confusing to others.

Thank you,
Kyungmin Park

On Sat, Sep 25, 2010 at 9:15 PM, Jassi Brar <jassisinghbrar@gmail.com> wrot=
e:
> On Sat, Sep 25, 2010 at 5:16 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> Since Jassi is doing so much good work and can offer such good review
>> for the Samsung CPU support add an entry for the Samsung ASoC drivers
>> to MAINTAINERS listing him.
>>
>> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
>> ---
>> =A0MAINTAINERS | =A0 =A06 ++++++
>> =A01 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b5b8baa..f51409b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4965,6 +4965,12 @@ F: =A0 =A0 =A0 drivers/media/common/saa7146*
>> =A0F: =A0 =A0 drivers/media/video/*7146*
>> =A0F: =A0 =A0 include/media/*7146*
>>
>> +SAMSUNG AUDIO (ASoC) DRIVERS
>> +M: =A0 =A0 Jassi Brar <jassi.brar@samsung.com>
>> +L: =A0 =A0 alsa-devel@alsa-project.org (moderated for non-subscribers)
>> +S: =A0 =A0 Supported
>> +F: =A0 =A0 sound/soc/s3c24xx
>> +
>> =A0TLG2300 VIDEO4LINUX-2 DRIVER
>> =A0M: =A0 =A0 Huang Shijie <shijie8@gmail.com>
>> =A0M: =A0 =A0 Kang Yong <kangyong@telegent.com>
>
> Acked-by: Jassi Brar <jassi.brar@samsung.com>
>
> Thanks.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

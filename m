From: "R. Lemos" <rslemos@gmail.com>
Subject: Re: On mixer controls naming
Date: Mon, 13 Jan 2014 22:31:02 -0200
Message-ID: <CAM6_cxx_FDftjsBFsg660GG2H+zEP_iy6o7YVsMK7_Xcn8N8AA@mail.gmail.com>
References: <CAM6_cxyGVC+Tzt=6AM=LXn2Eqt48AK4JMSJkfbR07pPgPwBtcA@mail.gmail.com>
 <52D3CA28.3070500@ladisch.de>
 <CAM6_cxz3ZOOtF4c9rY6-v6J-7GpXL14VVa0ajAXBZEsPCz=+HQ@mail.gmail.com>
 <52D43526.8040600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f41.google.com (mail-qe0-f41.google.com
 [209.85.128.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 711892610A8
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 01:31:03 +0100 (CET)
Received: by mail-qe0-f41.google.com with SMTP id gh4so8015401qeb.28
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 16:31:02 -0800 (PST)
In-Reply-To: <52D43526.8040600@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'll stick to "Bass Playback Volume" (shows up as "Bass", only
playback channel).

Thank you for your support.


On Mon, Jan 13, 2014 at 4:49 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> R. Lemos wrote:
>> On Mon, Jan 13, 2014 at 9:12 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>>> For a control to be classified as a playback control, its name must
>>> have one of the suffixes " Playback Enum", " Playback Switch",
>>> " Playback Route", or " Playback Volume".
>>
>> Unfortunately it doesn't work for Tone Control.
>>
>> Simple mixer control 'Master Playback Bass',0
>> Simple mixer control 'Master Playback Tone',0
>> Simple mixer control 'Playback Tone - Bass',0
>> Simple mixer control 'Playback Tone Control - Bass',0
>> ...
>
> "Suffix" means "at the end".  Try "Tone Control Bass Playback Volume".
>
>
> Regards,
> Clemens



-- 
[]'s
Rodrigo
Powered by carbohydrates

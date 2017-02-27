From: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
Subject: Re: [PATCH 1/1] ASoC: Add AU1761 audio codec as
 selectable option
Date: Mon, 27 Feb 2017 08:01:01 -0600
Message-ID: <CAKGmAFq3gAu_gDw47aRPNwB0Xrs7L9fBCdtckmKTk7Juu6+FLw@mail.gmail.com>
References: <3e3bc465-0b9a-161f-a3f2-b26149276411@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from secvs01.rockwellcollins.com (secvs01.rockwellcollins.com
 [205.175.225.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AE6E266C5D
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 15:01:04 +0100 (CET)
Received: by mail-ua0-f199.google.com with SMTP id x24so15466723uab.6
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 06:01:02 -0800 (PST)
In-Reply-To: <3e3bc465-0b9a-161f-a3f2-b26149276411@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, me@rockwellcollins.com
List-Id: alsa-devel@alsa-project.org

Lars,

On Mon, Feb 27, 2017 at 5:33 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 02/24/2017 10:00 PM, me@rockwellcollins.com wrote:
>> From: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
>>
>> This commit adds the ADI AU1761 audio codec as a selectable option
>> in the kernel config.  Currently the driver can only be selected
>> for ADI blackfin devices or if SND_SOC_ALL_CODECS is enabled.
>>
>> Signed-off-by: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
>
> Looks good, makes sense.
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
> But you need to send the patch to the ASoC maintainers Mark
> (<broonie@kernel.org>) and Liam (girdwood@gmail.com) to get it applied. The
> patch should be send to the maintainers and with the mailinglist on CC.
>
> - Lars
>

I will make sure to do that.  Thank you very much for the input and
the direction.

-Bryce

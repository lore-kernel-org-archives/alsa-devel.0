From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2 4/6] ASoC: sirf-soc-inner: add drivers
 for both CPU and Codec DAIs
Date: Tue, 29 Oct 2013 16:32:21 +0800
Message-ID: <CAGsJ_4xG6KaxrrrsaWJi9K3444JFT5h6sB-qV2VK8++NXuXkaQ@mail.gmail.com>
References: <1383001534-20703-1-git-send-email-Baohua.Song@csr.com>
 <20131028233603.GA16686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com
 [209.85.160.47])
 by alsa0.perex.cz (Postfix) with ESMTP id F03DE2610A2
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 09:32:42 +0100 (CET)
Received: by mail-pb0-f47.google.com with SMTP id rq2so7630337pbb.34
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 01:32:41 -0700 (PDT)
In-Reply-To: <20131028233603.GA16686@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

2013/10/29 Mark Brown <broonie@kernel.org>:
> On Tue, Oct 29, 2013 at 07:05:34AM +0800, Barry Song wrote:
>> From: Rongjun Ying <Rongjun.Ying@csr.com>
>>
>> there is an internal codec embedded in the SiRF SoC. this is not
>
> I've only got patch 4 - where are the other patches?
sorry i got some network problems and made some misoperations. others
have been in your mailboxs:
[PATCH v2 1/6] ASoC: sirf: add sirf platform driver which provides DMA
http://www.spinics.net/lists/arm-kernel/msg282590.html
[PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
http://www.spinics.net/lists/arm-kernel/msg282591.html
[PATCH v2 3/6] ASoC: usp-pcm: add CPU DAI driver for PCM simulated from USP
http://www.spinics.net/lists/arm-kernel/msg282592.html
...
-barry

From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: Add missing platform_device_put in
 raumfeld_audio_init error path
Date: Sun, 4 Sep 2011 18:36:51 +0200
Message-ID: <CACTFLANKizyLnK0JsOoSoySzKQ-cYOoYjHHfxjRVjbeqnec9xg@mail.gmail.com>
References: <1314971261.3699.0.camel@phoenix>
	<20110904155459.GC21528@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 86C9F244F5
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Sep 2011 18:36:53 +0200 (CEST)
Received: by ywt32 with SMTP id 32so2915280ywt.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Sep 2011 09:36:51 -0700 (PDT)
In-Reply-To: <20110904155459.GC21528@opensource.wolfsonmicro.com>
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
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 4, 2011 at 5:55 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Sep 02, 2011 at 09:47:41PM +0800, Axel Lin wrote:
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> Applied, thanks.

Feel free to add my Acked-by as well, if it's not too late.


Thanks,
Daniel

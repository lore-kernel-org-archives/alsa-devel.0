From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH linux-next v3 1/1] ASoC: ad193x: add support
 to ad1934
Date: Mon, 05 Oct 2015 18:40:23 +0200
Message-ID: <5612A7F7.3020607@metafoo.de>
References: <5fa6cd7e991982cea9f52d5ebba7a3aca7350ed7.1443537293.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5fa6cd7e991982cea9f52d5ebba7a3aca7350ed7.1443537293.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Looks basically good.

On 09/29/2015 04:41 PM, Cyrille Pitchen wrote:
> The AD1934 codec has no DAC feature. Hence it register mapping is slightly

Should be "has no ADC feature". Otherwise

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

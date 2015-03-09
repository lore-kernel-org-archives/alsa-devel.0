From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH_V3] ASoC: jz4740: Add jz4780 support
Date: Mon, 09 Mar 2015 13:22:28 +0100
Message-ID: <54FD9084.40106@metafoo.de>
References: <1425903068-60790-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425903068-60790-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/09/2015 01:11 PM, Zubair Lutfullah Kakakhel wrote:
> The jz4780 and jz4740 have very similar i2s blocks.
>
> The slight difference is in Rx/Tx fifos.
> And the bitclocks for input/output are different.
>
> This patch adds jz4780 support to the driver
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

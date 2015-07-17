From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8173: Add afe device node
Date: Fri, 17 Jul 2015 23:42:25 +0200
Message-ID: <1607394.WYm4U533YM@ubix>
References: <1436412725-55129-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436412725-55129-1-git-send-email-koro.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, djkurtz@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thursday, July 09, 2015 11:32:05 AM Koro Chen wrote:
> This adds afe (audio front end) device node to the MT8173 dtsi file.
> 
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> ---
> This patch is based on Matthias's tree:
> https://github.com/mbgg/linux-mediatek
> branch: v4.2-next/arm64
> 
> Changes since v1:
> - change node name to afe: audio-controller@11220000
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 32
> ++++++++++++++++++++++++++++++++ 1 file changed, 32 insertions(+)

Applied, thanks.

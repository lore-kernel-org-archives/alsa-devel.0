From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/4] dt-bindings: ASoC: Add WSA881x bindings
Date: Thu, 29 Aug 2019 14:32:55 -0500
Message-ID: <CAL_JsqKq228oWZzSWykBtGSy8qwwn48q-nYfExhiKMTAzj+-+g@mail.gmail.com>
References: <20190829163514.11221-1-srinivas.kandagatla@linaro.org> <20190829163514.11221-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829163514.11221-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>, spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 29, 2019 at 11:36 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
> Amplifier. This Amplifier also has a simple thermal sensor for
> over temperature and speaker protection.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wsa881x.yaml          | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

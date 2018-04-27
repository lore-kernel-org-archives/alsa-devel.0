From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 03/24] ASoC: qdsp6: dt-bindings: Add
	q6core dt bindings
Date: Fri, 27 Apr 2018 09:10:34 -0500
Message-ID: <20180427141034.qsk5o2erd5x6cm2f@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C6322677FD
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 16:10:36 +0200 (CEST)
Received: by mail-ot0-f195.google.com with SMTP id g7-v6so2153724otj.11
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 07:10:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-4-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 10:45:45AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for Q6CORE DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6core.txt       | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt

Reviewed-by: Rob Herring <robh@kernel.org>

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 04/24] ASoC: qdsp6: dt-bindings: Add
	q6afe dt bindings
Date: Tue, 1 May 2018 07:37:18 -0500
Message-ID: <20180501123718.GA25915@rob-hp-laptop>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 853F926735E
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 14:37:20 +0200 (CEST)
Received: by mail-ot0-f195.google.com with SMTP id h8-v6so12782255otb.2
 for <alsa-devel@alsa-project.org>; Tue, 01 May 2018 05:37:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 01, 2018 at 01:08:00PM +0100, Srinivas Kandagatla wrote:
> This patch add DT bindings for AFE (Audio Frontend) DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.txt       | 104 +++++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6afe.h             |  31 ++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>  create mode 100644 include/dt-bindings/sound/qcom,q6afe.h

Reviewed-by: Rob Herring <robh@kernel.org>

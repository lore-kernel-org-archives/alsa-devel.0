From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2 1/5] ASoC: qcom: sdm845: Add board
 specific dapm widgets
Date: Wed, 5 Dec 2018 14:18:25 +0000
Message-ID: <a6401825-6ca4-d187-5626-4843c660c7fb@linaro.org>
References: <20181128090037.257359-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128090037.257359-1-cychiang@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, tzungbi@chromium.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi Jimmy,


On 28/11/18 09:00, Cheng-Yi Chiang wrote:
> Add board specific dapm widgets so these widgets can be used
> in the route.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>   sound/soc/qcom/sdm845.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 


Am not sure why are you sending patches that are already applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next

It just wastes other people time in looking at something which is 
already applied.
Also it looks like you have not picked acked-bys on some of the patches!

thanks,
srini

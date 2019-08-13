From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/5] soundwire: Add compute_params callback
Date: Tue, 13 Aug 2019 19:17:10 +0100
Message-ID: <1a02f190-0aab-d512-ceb0-4a21014705e8@linaro.org>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
 <7e462330-a357-698a-b259-5ff136963a57@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7e462330-a357-698a-b259-5ff136963a57@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 13/08/2019 15:34, Pierre-Louis Bossart wrote:
> On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
>> From: Vinod Koul <vkoul@kernel.org>
>>
>> This callback allows masters to compute the bus parameters required.
> 
> This looks like a partial use of the patch ('soundwire: Add Intel 
> resource management algorithm')? see comments below
> 

Yes it duplicate indeed!

I will use that patch!

--srini

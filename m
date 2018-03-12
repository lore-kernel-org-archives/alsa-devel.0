From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Mon, 12 Mar 2018 18:29:37 -0500
Message-ID: <4780c8aa-face-d811-3bd8-7c2c2ea85eb6@linux.intel.com>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
 <20180312161455.GD2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180312161455.GD2186@sirena.org.uk>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 3/12/18 11:14 AM, Mark Brown wrote:
> On Mon, Feb 26, 2018 at 07:34:07PM +0100, Kirill Marinushkin wrote:
>> Hello Mark Brown, Pan Xiuli,
>>
>> As far as I understand, the suggested commit *breaks* the functionality instead
>> of fixing it, and should not be applied. Please correct me if I am wrong.
> 
> This discussion ground to a halt a bit (nobody from Intel seems to have
> looked at Kirill's patches?) so I'm going to drop this patch for now,
> I'll keep a copy around at test/topology.

Sorry, we did look at Kirill's patches but wanted to test further, and 
of course we are caught in the middle of a release.
It's fine to drop this for now.

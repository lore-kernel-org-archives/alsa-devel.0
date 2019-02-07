From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: sound: Document jz4740-codec bindings
Date: Thu, 07 Feb 2019 11:17:37 -0300
Message-ID: <1549549058.24598.0@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
        <20190207140031.GB6190@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207140031.GB6190@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Feb 7, 2019 at 11:00 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 07, 2019 at 10:31:38AM -0300, Paul Cercueil wrote:
>>  Add documentation about how to probe the jz4740-codec driver from
>>  devicetree.
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Well you only applied patch 6/6, didn't you? I only see this one in your
tree.

-Paul

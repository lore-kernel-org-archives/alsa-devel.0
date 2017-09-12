From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/7] mfd: arizona: Remove audio bindings from MFD binding
 document
Date: Tue, 12 Sep 2017 16:15:22 -0500
Message-ID: <20170912211522.obvj4vnpm75diftq@rob-hp-laptop>
References: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
 <20170904154154.4395-6-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170904154154.4395-6-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 04, 2017 at 04:41:52PM +0100, Charles Keepax wrote:
> Now the audio bindings have their own binding document update the main
> MFD document to point to that file and remove the audio binding
> documentation.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt | 40 +----------------------
>  1 file changed, 1 insertion(+), 39 deletions(-)

Acked-by: Rob Herring <robh@kernel.org> 

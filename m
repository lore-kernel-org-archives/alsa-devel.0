From: Li Xu <li.xu@cirrus.com>
Subject: Re: [PATCH v2 2/2] ASoC: cs43130: Add devicetree
	bindings for CS43130
Date: Tue, 22 Aug 2017 09:18:54 -0500
Message-ID: <154cc0d8-05af-4a17-b426-5a1f5b916372@EX3.ad.cirrus.com>
References: <1503072020-19999-1-git-send-email-li.xu@cirrus.com>
 <65594a37-aecf-4be2-bc5e-f392b4d9a129@EX3.ad.cirrus.com>
 <20170821233147.75jndug3j7lcggcp@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id C26DB266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 16:17:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170821233147.75jndug3j7lcggcp@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, brian.austin@cirrus.com, tiwai@suse.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 21, 2017 at 06:31:48PM -0500, Rob Herring wrote:
> On Fri, Aug 18, 2017 at 11:00:20AM -0500, Li Xu wrote:
> > Add devicetree bindings documentation file for Cirrus
> > Logic CS43130 codec.
> > 
> > Signed-off-by: Li Xu <li.xu@cirrus.com>
> > ---
> >  .../devicetree/bindings/sound/cs43130.txt          | 67 ++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/cs43130.txt
> 
> For the 4th time, I'm acking this (v2 and v3 last Dec and the new v1 a 
> few weeks ago). Please add acks when posting new versions.
> 
> Though you keep changing something looking at the diffstats. I'm not 
> sure what though because you have no version history.
> 
> Rob

Thanks for the feedback.  I am new to Linux kernel patch submission.

I will add cover letter to patch set, which would explain version change info.
I will also add "Acked-by: Rob Herring <robh@kernel.org>" in commit message below
"Signed-off-by: ..."


Li

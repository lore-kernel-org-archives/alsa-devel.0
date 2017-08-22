From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v2 1/2] ASoC: cs43130: Add support for
 CS43130 codec
Date: Tue, 22 Aug 2017 01:41:19 +0000
Message-ID: <298a3712-a367-47b4-878d-72cf6d55aea7@EX4.ad.cirrus.com>
References: <a71e2771-fec4-4d15-af95-ec15e010fd0c@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 828B3266D86
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 03:41:24 +0200 (CEST)
In-Reply-To: <a71e2771-fec4-4d15-af95-ec15e010fd0c@EX3.ad.cirrus.com>
Content-Language: en-US
Content-ID: <2639A216243C404F941F7D589C7667E5@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Xu, Li" <Li.Xu@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "tiwai@suse.com" <tiwai@suse.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On 8/19/17, 2:57 AM, "alsa-devel-bounces@alsa-project.org on behalf of Li Xu" <alsa-devel-bounces@alsa-project.org on behalf of li.xu@cirrus.com> wrote:

    Add support for Cirrus Logic CS43130 codec.
    
    Support:
    I2S/DSP PCM playback.
    DoP/DSD playback.
    HP detection and DC/AC impedance measurement.
    
    Signed-off-by: Li Xu <li.xu@cirrus.com>
    ---
Acked-by: Brian Austin <brian.austin@cirrus.com> 

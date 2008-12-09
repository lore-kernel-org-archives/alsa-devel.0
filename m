From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: question on hardware mixing
Date: Mon, 8 Dec 2008 22:15:45 -0500
Message-ID: <75b66ecd0812081915w1f718d7dp605ea2bbc6c099d9@mail.gmail.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
	<75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
	<98769532B4BB14429434178695419EAE268614A1@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f20.google.com (mail-qy0-f20.google.com
	[209.85.221.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 748021037EB
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 04:15:46 +0100 (CET)
Received: by qyk13 with SMTP id 13so2275138qyk.8
	for <alsa-devel@alsa-project.org>; Mon, 08 Dec 2008 19:15:45 -0800 (PST)
In-Reply-To: <98769532B4BB14429434178695419EAE268614A1@bgsmsx501.gar.corp.intel.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 6, 2008 at 1:56 AM, Harsha, Priya <priya.harsha@intel.com> wrote:
> Hi,
>
> Thanks.
>
> A quick follow up question. In the trigger function - I see that from substream->runtime->private_data, voice specific parameters are extracted. How and can somehow user space fill in some private data to the driver so that driver can process voice in a different way and music in a different way?
>

What exactly do you want to do differently?

Lee

From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: PS3 - Surround sound on SPDIF set-up
Date: Tue, 3 Jul 2007 11:27:58 -0400
Message-ID: <75b66ecd0707030827t7d5e71c5ya5f79a44009cb39f@mail.gmail.com>
References: <4689B1BF.2050709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 12E1724427
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 17:28:02 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id q12so2133163qba
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 08:28:01 -0700 (PDT)
In-Reply-To: <4689B1BF.2050709@gmail.com>
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
To: gt bradley <gt.bradley@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/2/07, gt bradley <gt.bradley@gmail.com> wrote:
> Hi,
> I've been beating my had against this for several weeks now.  (started
> with fedora 6, tried adding in the plugings etc (version 1.0.12) -- also
> tried upgrading to the current 1.0.14 version, without success (couldn't
> produce surround-sound on teh spdif output).  I have now switched to
> fedorea 7 and was able to have rythmbox play surround sound via spdif,
> but have since lost that ability.  (but I'm convinced the hardware and
> low-level drivers support it).  In order to limit the number of moving
> parts, I have reduced to just trying to get speaker-test to play on all
> 6 speakers.

SPDIF only supports 2 channels unless the stream is AC3 encoded.

Lee

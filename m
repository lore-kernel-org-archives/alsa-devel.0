From: "Josh Litherland" <josh@temp123.org>
Subject: Re: Userspace drivers
Date: Thu, 27 Sep 2007 10:38:37 -0400
Message-ID: <6cc714350709270738i61f2f591y87a0e888b52ced9b@mail.gmail.com>
References: <6cc714350709261228v519ab4dcx657969fd07f022b0@mail.gmail.com>
	<46FBA80E.7010004@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by alsa0.perex.cz (Postfix) with ESMTP id D8D892449D
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Sep 2007 16:38:38 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so1681135nzf
	for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2007 07:38:37 -0700 (PDT)
In-Reply-To: <46FBA80E.7010004@keyaccess.nl>
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
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/27/07, Rene Herman <rene.herman@keyaccess.nl> wrote:

> assuming the volume control shows up
> in say alsamixer same as if it had been a hardware control, you'd have an
> example of a userspace volume control there

Thanks, this looks like exactly the hook I was needing.  Now to try to
grok it.  =D

-- 
Josh Litherland (josh@temp123.org)

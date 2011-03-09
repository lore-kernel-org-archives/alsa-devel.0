From: kuberasamrat <kubera.samrat@gmail.com>
Subject: Re: some questions about sound system
Date: Wed, 9 Mar 2011 06:23:00 +0000 (UTC)
Message-ID: <loom.20110309T072132-474@post.gmane.org>
References: <AANLkTinPWzmmaP9OrHLKbZqCgGQuSGrpqUPtdW2Qi8ov@mail.gmail.com>
	<AANLkTi=A27r6QhQGdK8=HhsPbTKphoGB6GNZ3M6MHbns@mail.gmail.com>
	<AANLkTin_er-Ytg6hpF+jN3p6qoRnmEag==OjJLw_iD_J@mail.gmail.com>
	<AANLkTim+O7BmWopW1U_G0hQEwChJSy-On+RZiiVj=KhF@mail.gmail.com>
	<AANLkTikVsWmZkcNb7svt=-19byeBeBg4G+42Y_9yR6X1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id C61A624508
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 07:30:09 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PxCuL-000139-GA
	for alsa-devel@alsa-project.org; Wed, 09 Mar 2011 07:30:05 +0100
Received: from 115.111.25.162 ([115.111.25.162])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 07:30:05 +0100
Received: from kubera.samrat by 115.111.25.162 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 07:30:05 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


sudo apt-get install ncursesw5-dev

Daniel Chen <seven.steps <at> gmail.com> writes:

> 
> On Sat, Jul 31, 2010 at 12:21 PM, loody <miloody <at> gmail.com> wrote:
> > checking for new_panel in -lpanelw... no
> > configure: error: panelw library not found
> 
> $ sudo aptitude install libncurses5-dev
> 


instead of ncurses5-dev      install ncursesw5-dev
it will work

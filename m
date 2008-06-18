From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: can we make the log appears in subject instead of
	useless sha1 ID?
Date: Wed, 18 Jun 2008 11:58:12 +0200
Message-ID: <m2y753oyiz.fsf_-_@vador.mandriva.com>
References: <20080520112539.81C9D2484D@alsa0.perex.cz>
	<m2bq2xtixw.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.mandriva.com [212.85.150.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F345103808
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 11:58:15 +0200 (CEST)
Received: from office.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "office.mandrakesoft.com",
	Issuer "smtp.mandrakesoft.com" (not verified))
	by mx1.mandriva.com (Postfix) with ESMTP id D67E11F0076
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 11:58:11 +0200 (CEST)
Received: from vador.mandriva.com (anakin.mandriva.com [192.168.100.54])
	by office.mandriva.com (Postfix) with ESMTP id D237C7EE2
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 11:58:12 +0200 (CEST)
Received: from vador.mandriva.com (vador.mandriva.com [127.0.0.1])
	by vador.mandriva.com (Postfix) with ESMTP id 4B4771BE83
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 11:58:12 +0200 (CEST)
In-Reply-To: <m2bq2xtixw.fsf@vador.mandriva.com> (Thierry Vignaud's message of
	"Fri\, 23 May 2008 12\:26\:35 +0200")
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

Thierry Vignaud <tvignaud@mandriva.com> writes:

> > This is an automated email from the git hooks/update script, it was
> > generated because a ref change was pushed to the repository.
> > 
> > Updating branch, master,
> >        via  9d46f4a919532c3f29a4ca1df3a4ce4686b11f37 (commit)
> >       from  fc5102d6c6520f48d39faf572881bc520c41aeb7 (commit)
> > 
> > - Log -----------------------------------------------------------------
> > commit 9d46f4a919532c3f29a4ca1df3a4ce4686b11f37
> > Author:     Jaroslav Kysela <perex@perex.cz>
> > AuthorDate: Tue May 20 13:25:35 2008 +0200
> > Commit:     Jaroslav Kysela <perex@perex.cz>
> > CommitDate: Tue May 20 13:25:35 2008 +0200
> > 
> >     removed .hgtags
> 
> can we make the log appears in subject instead of useless sha1 ID?

I ask again if we could make the change log appears in subject instead
of useless sha1 ID?

Current commits mails are fare less readable than previous ones (when
using hg).  This is a regression... :-(

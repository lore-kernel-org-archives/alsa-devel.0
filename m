From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: User land drivers.
Date: Fri, 3 Sep 2004 15:11:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040903151112.0aa754c2@mango.fruits.de>
References: <413456AE.7000007@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 4E90F29A
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 14:58:45 +0200 (MEST)
In-Reply-To: <413456AE.7000007@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 31 Aug 2004 11:45:02 +0100
James Courtier-Dutton <James@superbug.demon.co.uk> wrote:


> Would it be possible to have userland processes creating /dev/ files ?
> Alternatively, could we provide a new plugin method, so we can add 
> userland PCMs, Mixer, etc.
> 
> Any ideas?

have a look for userspace file systems. I suppose many of the techniques
can be adopted to this..

http://www.circlemud.org/~jelson/software/fusd/

for example

flo


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

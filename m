From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: ALSA Programming Interface for Kernel 2.6.8
Date: Tue, 7 Sep 2004 13:04:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907130432.4318a5d0@mango.fruits.de>
References: <20040907103237.46836.qmail@web8503.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040907103237.46836.qmail@web8503.mail.in.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Sep 2004 11:32:37 +0100 (BST)
Dinesh Ahuja <mdlinux7@yahoo.co.in> wrote:

> I have build and installed Kernel 2.6.8 which has a
> ALSA support. I want to do a programming with ALSA
> API's and for that I should get the hold of developers
> kit which will provide me all the neccessary headers
> and libraries to work with.
> 
> Could anyone suggest me how to proceed with ALSA
> programming and from where I can get the Developer Kit
> for my new Kernel 2.6.8.
> 
> I have following ALSA version from
> /proc/asound/version
> 
> Advanced Linux Sound Architecture Driver Version 1.0.4
> (Mon May 17 14:31:44 2004 UTC).
> Compiled on Sep  7 2004 for kernel 2.6.8.

Hi,

depending on your distribution all you need to do is to install a
alsa-dev or libasound-dev pakage [naming differs from dist to dist]. The
api docs should be available on alsa-project.org, though somewhat
obfuscated, thus here's a direct link:

hrrrmm, alsa-project.org is down for me atm

Well, i think the api docs were mising anyways the last time i checked.
But you could also grab an alsa-lib tarball and generate the docs from
that. Well, to get an alsa-lib tarball alsa-project.org would need to be
up, too :) So just wait until it's back up again..

flo


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

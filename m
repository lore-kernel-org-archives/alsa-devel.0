From: Paul Davis <pbd@op.net>
Subject: Re: ALSA docs
Date: Thu, 25 Jul 2002 12:32:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17XlTw-00041v-00@usw-sf-list1.sourceforge.net>
References: <3D402544.5010008@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 26 Jul 2002 01:20:20 +0900."
             <3D402544.5010008@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net, linux-audio-user@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

>I have the working version of the template for the new improved docs.
>
>Can people who have a spare moment have a look through it for obvious 
>mistakes. Any additions to the text will also be appreciated.
>
>I've looked at it so many times now I need a fresh eye to spot my mistakes.
>
>http://www.alsa-project.org/alsa-doc/doc-php/cmipci.php3

no mistakes, but i still think it very, very important that the link
to the section on card-specific options be clear and distinct from
everything else. 

new users may want to see the rest, but in a relatively short time,
most of the views of this page will be by people who are looking up
specific information. there is a link to this already, but its not
obvious enough for my taste.

put it as the first element in the "table of contents", and use a
couple of <br> elements to make it stand apart from the rest.

there also needs to be a place for information about card-specific
control switches too.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim

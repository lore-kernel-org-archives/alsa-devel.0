From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Echoaudio drivers
Date: Thu, 20 Feb 2003 16:40:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030220164059.pochini@shiny.it>
References: <200302201537.30655.david@olofson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200302201537.30655.david@olofson.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Olofson <david@olofson.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 20-Feb-2003 David Olofson wrote:
> On Thursday 20 February 2003 10.17, Giuliano Pochini wrote:
>> Is someone writing drivers for Echoaudio cards ?  Perhaps
>> I'll buy one soon and I can try to write drivers if nobody
>> alse is working on it.
>
> I have an old Layla20 and intend to write a driver for it. It
> shouldn't be too much work to get the other cards working I think,
> but I can't test on anything but Layla20 myself.

According to official docs, 20 and 24bit versions have only a
different DAC. The driver always sends data in the same format.
I've not looked at the sources yet.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge

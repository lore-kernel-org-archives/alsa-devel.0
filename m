From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: documentation - yeah right!
Date: Tue, 20 May 2003 23:52:12 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305202327370.17272-100000@ecabase.localdomain>
References: <PM.9386.1053461408@pmweb11.uk1.bibliotech.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <PM.9386.1053461408@pmweb11.uk1.bibliotech.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 20 May 2003, Cliff Bradshaw wrote:

> doxygen is just an excuse to avoid writing documentation and should be
> banned from all projects. If I want a list of all the damn globals I'll
> look in the source code thankyou.

That's just not true at all. Existing ALSA API reference documentation
(written using the Doxygen notation) provides far more info than just a
list of globals. It's not perfect, but still, making false claims like
that is not a very good way to start a discussion.

FWIW, I've seen Doxygen used very succesfully in many large-scale
projects. It's not a replacement for higher level documentation of course,
but it's absolutely brilliant replacement for those overly verbose
function/class reference docs (ugh, think of huge word/pdf docs that list
each and every variable and function, which in addition to providing
little extra value, require different tools to read and edit, are
versioned with different tools, are not in sync with the source-code, etc,
etc).

PS I'd suggest making a pdf, generated from the doxygen ALSA docs, and put 
   it on the ALSA website (automatically generated or at each major 
   release). As we all know, if it's not a pdf/doc, it's not 
   real documentation. ;)

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
